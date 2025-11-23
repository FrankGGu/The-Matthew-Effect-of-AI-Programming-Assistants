impl Solution {
    pub fn min_height_shelves(books: Vec<Vec<i32>>, shelf_width: i32) -> i32 {
        let n = books.len();
        // dp[i] stores the minimum total height to place the first i books (books[0]...books[i-1]).
        // The array size is n + 1, to accommodate dp[0] for 0 books.
        let mut dp = vec![0; n + 1];

        // Base case: 0 books require 0 height.
        dp[0] = 0;

        // Iterate through each possible number of books from 1 to n.
        for i in 1..=n {
            // Initialize dp[i] to a very large value, as we're looking for the minimum.
            dp[i] = i32::MAX;

            let mut current_shelf_width = 0;
            let mut current_shelf_height = 0;

            // Iterate backwards from the current book (books[i-1]) to find all possible
            // starting points (books[j]) for the last shelf.
            // This means books[j] through books[i-1] are placed on the current shelf.
            for j in (0..i).rev() {
                let book_width = books[j][0];
                let book_height = books[j][1];

                current_shelf_width += book_width;

                // If adding this book exceeds the shelf width, we cannot place
                // books[j]...books[i-1] on the current shelf.
                // Any further books (books[j-1] and before) would also exceed the width.
                if current_shelf_width > shelf_width {
                    break;
                }

                // The height of the current shelf is determined by the tallest book on it.
                current_shelf_height = current_shelf_height.max(book_height);

                // If dp[j] is reachable (not MAX), calculate the total height for this configuration.
                // dp[j] is the minimum height for books[0]...books[j-1].
                // current_shelf_height is the height of the shelf containing books[j]...books[i-1].
                if dp[j] != i32::MAX {
                    dp[i] = dp[i].min(dp[j] + current_shelf_height);
                }
            }
        }

        // The result is the minimum height to place all n books.
        dp[n]
    }
}