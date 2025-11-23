impl Solution {
    pub fn max_sum(arr: Vec<Vec<i32>>) -> i32 {
        let mut max_sum = i32::MIN;
        let rows = arr.len();
        let cols = arr[0].len();

        for i in 0..rows - 2 {
            for j in 0..cols - 2 {
                let hourglass_sum = arr[i][j] + arr[i][j + 1] + arr[i][j + 2] +
                                    arr[i + 1][j + 1] +
                                    arr[i + 2][j] + arr[i + 2][j + 1] + arr[i + 2][j + 2];
                max_sum = max_sum.max(hourglass_sum);
            }
        }

        max_sum
    }
}