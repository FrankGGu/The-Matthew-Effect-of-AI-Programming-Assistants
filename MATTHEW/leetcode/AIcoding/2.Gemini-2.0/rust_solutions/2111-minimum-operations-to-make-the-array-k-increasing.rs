impl Solution {
    pub fn k_increasing(arr: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = arr.len();
        let mut ans = 0;

        for i in 0..k {
            let mut sub = Vec::new();
            let mut j = i;
            while j < n {
                sub.push(arr[j]);
                j += k;
            }

            let len = sub.len();
            let mut tail = Vec::new();

            for &num in &sub {
                if tail.is_empty() || num >= *tail.last().unwrap() {
                    tail.push(num);
                } else {
                    let mut left = 0;
                    let mut right = tail.len() - 1;
                    while left < right {
                        let mid = left + (right - left) / 2;
                        if tail[mid] <= num {
                            left = mid + 1;
                        } else {
                            right = mid;
                        }
                    }
                    tail[left] = num;
                }
            }
            ans += (len - tail.len()) as i32;
        }

        ans
    }
}