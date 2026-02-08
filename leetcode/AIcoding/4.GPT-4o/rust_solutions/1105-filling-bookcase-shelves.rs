pub fn min_height_shelves(books: Vec<Vec<i32>>, shelf_width: i32) -> i32 {
    let n = books.len();
    let mut dp = vec![i32::MAX; n + 1];
    dp[0] = 0;

    for i in 1..=n {
        let mut width = 0;
        let mut height = 0;

        for j in i as isize - 1; j >= 0 && width + books[j as usize][0] <= shelf_width; j -= 1 {
            width += books[j as usize][0];
            height = height.max(books[j as usize][1]);
            dp[i] = dp[i].min(dp[j as usize] + height);
        }
    }

    dp[n]
}