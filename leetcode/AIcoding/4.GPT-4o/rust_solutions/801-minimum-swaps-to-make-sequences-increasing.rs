impl Solution {
    pub fn min_swap(a: Vec<i32>, b: Vec<i32>) -> i32 {
        let n = a.len();
        let mut swap = vec![0; n];
        let mut no_swap = vec![0; n];

        for i in 1..n {
            swap[i] = no_swap[i] = n as i32;
            if a[i] > a[i - 1] && b[i] > b[i - 1] {
                no_swap[i] = no_swap[i - 1];
                swap[i] = swap[i - 1] + 1;
            }
            if a[i] > b[i - 1] && b[i] > a[i - 1] {
                no_swap[i] = no_swap[i].min(swap[i - 1]);
                swap[i] = swap[i].min(no_swap[i - 1] + 1);
            }
        }

        swap[n - 1].min(no_swap[n - 1])
    }
}