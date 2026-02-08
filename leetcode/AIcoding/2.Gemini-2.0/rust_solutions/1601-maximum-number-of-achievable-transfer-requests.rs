impl Solution {
    pub fn maximum_number_of_achievable_transfer_requests(n: i32, requests: Vec<Vec<i32>>) -> i32 {
        let m = requests.len();
        let mut ans = 0;
        for mask in 0..(1 << m) {
            let mut balance = vec![0; n as usize];
            let mut count = 0;
            for i in 0..m {
                if (mask >> i) & 1 == 1 {
                    balance[requests[i][0] as usize] -= 1;
                    balance[requests[i][1] as usize] += 1;
                    count += 1;
                }
            }
            if balance.iter().all(|&x| x == 0) {
                ans = ans.max(count);
            }
        }
        ans
    }
}