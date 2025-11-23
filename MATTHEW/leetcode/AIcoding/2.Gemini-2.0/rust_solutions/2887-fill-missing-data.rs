use chrono::NaiveDate;
use rusqlite::{Connection, Result};

#[derive(Debug)]
struct Dates {
    date: String,
}

pub fn fill_missing_data(database: String) -> Result<()> {
    let conn = Connection::open(database)?;

    conn.execute(
        "CREATE TABLE IF NOT EXISTS Dates (
             date TEXT NOT NULL
         )",
        [],
    )?;

    let mut stmt = conn.prepare("SELECT date FROM Dates")?;
    let dates_iter = stmt.query_map([], |row| {
        Ok(Dates {
            date: row.get(0)?,
        })
    })?;

    let mut dates: Vec<String> = Vec::new();
    for date in dates_iter {
        dates.push(date?.date);
    }

    if dates.is_empty() {
        return Ok(());
    }

    dates.sort();

    let start_date = NaiveDate::parse_from_str(&dates[0], "%Y-%m-%d").unwrap();
    let end_date = NaiveDate::parse_from_str(&dates[dates.len() - 1], "%Y-%m-%d").unwrap();

    let mut current_date = start_date;
    while current_date <= end_date {
        let date_str = current_date.format("%Y-%m-%d").to_string();
        if !dates.contains(&date_str) {
            conn.execute(
                "INSERT INTO Dates (date) VALUES (?)",
                [&date_str],
            )?;
        }
        current_date = current_date.succ();
    }

    Ok(())
}