pub fn min_shelves(books: Vec<i32>, shelf_width: i32) -> i32 {
    let mut dp = vec![0; books.len() + 1];
    for i in 1..=books.len() {
        let mut width = 0;
        let mut max_height = 0;
        dp[i] = i32::MAX;
        for j in i; j > 0; j -= 1 {
            width += books[j - 1];
            if width > shelf_width {
                break;
            }
            max_height = max_height.max(books[j - 1]);
            dp[i] = dp[i].min(dp[j - 1] + max_height);
        }
    }
    dp[books.len()]
}