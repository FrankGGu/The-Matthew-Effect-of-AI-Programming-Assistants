impl Solution {
    pub fn maximum_requests(n: i32, requests: Vec<Vec<i32>>) -> i32 {
        let num_requests = requests.len();
        let mut max_achievable_requests = 0;

        for i in 0..(1 << num_requests) {
            let mut current_requests_count = 0;
            let mut balance = vec![0; n as usize];

            for j in 0..num_requests {
                if (i >> j) & 1 == 1 {
                    current_requests_count += 1;
                    let from = requests[j][0] as usize;
                    let to = requests[j][1] as usize;
                    balance[from] += 1;
                    balance[to] -= 1;
                }
            }

            let mut is_achievable = true;
            for k in 0..(n as usize) {
                if balance[k] != 0 {
                    is_achievable = false;
                    break;
                }
            }

            if is_achievable {
                max_achievable_requests = max_achievable_requests.max(current_requests_count);
            }
        }

        max_achievable_requests
    }
}