impl Solution {
    pub fn maximum_requests(n: i32, requests: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut max_requests = 0;
        let m = requests.len();

        for mask in 0..(1 << m) {
            let mut balance = vec![0; n];
            let mut count = 0;

            for i in 0..m {
                if mask & (1 << i) != 0 {
                    let from = requests[i][0] as usize;
                    let to = requests[i][1] as usize;
                    balance[from] -= 1;
                    balance[to] += 1;
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