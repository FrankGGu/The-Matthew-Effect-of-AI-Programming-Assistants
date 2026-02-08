impl Solution {
    pub fn compare_version(version1: String, version2: String) -> i32 {
        let v1: Vec<i32> = version1.split('.').map(|s| s.parse().unwrap()).collect();
        let v2: Vec<i32> = version2.split('.').map(|s| s.parse().unwrap()).collect();

        let n1 = v1.len();
        let n2 = v2.len();

        let max_len = std::cmp::max(n1, n2);

        for i in 0..max_len {
            let num1 = if i < n1 { v1[i] } else { 0 };
            let num2 = if i < n2 { v2[i] } else { 0 };

            if num1 > num2 {
                return 1;
            } else if num1 < num2 {
                return -1;
            }
        }

        0
    }
}