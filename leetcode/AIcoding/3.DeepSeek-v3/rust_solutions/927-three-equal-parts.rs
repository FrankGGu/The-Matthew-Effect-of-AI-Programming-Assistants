impl Solution {
    pub fn three_equal_parts(arr: Vec<i32>) -> Vec<i32> {
        let ones: Vec<usize> = arr.iter().enumerate().filter(|(_, &x)| x == 1).map(|(i, _)| i).collect();
        let n = ones.len();
        if n == 0 {
            return vec![0, 2];
        }
        if n % 3 != 0 {
            return vec![-1, -1];
        }
        let k = n / 3;
        let (a, b, c) = (ones[0], ones[k], ones[2 * k]);
        let len = arr.len() - c;
        if a + len > b || b + len > c {
            return vec![-1, -1];
        }
        for i in 0..len {
            if arr[a + i] != arr[b + i] || arr[b + i] != arr[c + i] {
                return vec![-1, -1];
            }
        }
        vec![(a + len - 1) as i32, (b + len) as i32]
    }
}