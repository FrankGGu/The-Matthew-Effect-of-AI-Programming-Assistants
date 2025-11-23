use std::collections::HashSet;

# #[derive(Debug, PartialEq, Eq)]
# pub struct Book {
#     pub id: i32,
#     pub title: String,
#     pub author: String,
# }
# 
# #[derive(Debug, PartialEq, Eq)]
# pub struct Inventory {
#     pub book_id: i32,
#     pub available: bool,
# }
# 
impl Solution {
    pub fn find_books_no_available_copies(books: Vec<Book>, inventory: Vec<Inventory>) -> Vec<Book> {
        let mut available_books = HashSet::new();
        for inv in inventory {
            if inv.available {
                available_books.insert(inv.book_id);
            }
        }

        books
            .into_iter()
            .filter(|book| !available_books.contains(&book.id))
            .collect()
    }
}