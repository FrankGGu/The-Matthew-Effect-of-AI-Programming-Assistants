impl Solution {
    pub fn arrange_books(books: Vec<i32>) -> i32 {
        let mut count = 0;
        let n = books.len();
        for i in 0..n {
            for j in i + 1..n {
                if books[i] > books[j] {
                    count += 1;
                }
            }
        }
        count as i32
    }
}