use std::collections::HashMap;

impl Solution {
    pub fn find_books(stock: Vec<Vec<String>>, orders: Vec<Vec<String>>) -> Vec<String> {
        let mut book_stock: HashMap<String, i32> = HashMap::new();

        for book in &stock {
            let book_id = book[0].clone();
            let quantity = book[1].parse::<i32>().unwrap();
            book_stock.insert(book_id, quantity);
        }

        let mut unavailable_books: Vec<String> = Vec::new();

        for order in &orders {
            let book_id = order[0].clone();
            let quantity = order[1].parse::<i32>().unwrap();

            if let Some(&stock_quantity) = book_stock.get(&book_id) {
                if stock_quantity < quantity {
                    unavailable_books.push(book_id);
                }
            } else {
                unavailable_books.push(book_id);
            }
        }

        unavailable_books.sort();
        unavailable_books.dedup();
        unavailable_books
    }
}