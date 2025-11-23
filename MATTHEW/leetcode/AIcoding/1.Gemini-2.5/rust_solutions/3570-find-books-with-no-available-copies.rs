use std::collections::HashSet;

impl Solution {
    pub fn find_books_with_no_available_copies(books: Vec<Book>, orders: Vec<Order>) -> Vec<Book> {
        let mut ordered_book_ids: HashSet<i32> = HashSet::new();
        for order in orders {
            ordered_book_ids.insert(order.book_id);
        }

        let mut result: Vec<Book> = Vec::new();
        for book in books {
            if !ordered_book_ids.contains(&book.book_id) {
                result.push(book);
            }
        }
        result
    }
}