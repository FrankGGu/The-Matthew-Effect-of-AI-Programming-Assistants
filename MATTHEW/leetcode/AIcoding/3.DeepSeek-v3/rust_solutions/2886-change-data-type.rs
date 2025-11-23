impl Solution {
    pub fn change_data_type(students: Vec<Vec<String>>) -> Vec<Vec<String>> {
        students.into_iter().map(|mut row| {
            if let Ok(age) = row[1].parse::<i32>() {
                row[1] = age.to_string();
            }
            row
        }).collect()
    }
}