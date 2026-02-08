impl Solution {
    pub fn min_height_shelves(books: Vec<Vec<i32>>, shelf_width: i32) -> i32 {
        let n = books.len();
        let mut dp = vec![std::i32::MAX; n + 1];
        dp[0] = 0;

        for i in 1..=n {
            let mut width = 0;
            let mut height = 0;
            let mut j = i;
            while j > 0 {
                width += books[j - 1][0];
                if width > shelf_width {
                    break;
                }
                height = height.max(books[j - 1][1]);
                dp[i] = dp[i].min(dp[j - 1] + height);
                j -= 1;
            }
        }

        dp[n]
    }
}