impl Solution {
    pub fn maximum_requests(n: i32, requests: Vec<Vec<i32>>) -> i32 {
        let m = requests.len();
        let mut max_requests = 0;

        for mask in 0..(1 << m) {
            let mut balance = vec![0; n as usize];
            let mut count = 0;

            for i in 0..m {
                if mask & (1 << i) != 0 {
                    balance[requests[i][0] as usize] -= 1;
                    balance[requests[i][1] as usize] += 1;
                    count += 1;
                }
            }

            if balance.iter().all(|&x| x == 0) {
                max_requests = max_requests.max(count);
            }
        }

        max_requests
    }
}