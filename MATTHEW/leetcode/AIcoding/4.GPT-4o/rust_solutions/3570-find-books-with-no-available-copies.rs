pub fn find_books_with_no_available_copies(books: Vec<i32>, copies: Vec<i32>) -> Vec<i32> {
    let mut result = vec![];
    for (book, copy) in books.iter().zip(copies.iter()) {
        if *copy == 0 {
            result.push(*book);
        }
    }
    result
}