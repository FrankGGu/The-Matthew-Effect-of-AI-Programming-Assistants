impl Solution {
    pub fn compare_version(version1: String, version2: String) -> i32 {
        let v1: Vec<&str> = version1.split('.').collect();
        let v2: Vec<&str> = version2.split('.').collect();
        let max_len = std::cmp::max(v1.len(), v2.len());

        for i in 0..max_len {
            let num1 = if i < v1.len() { v1[i].parse::<i32>().unwrap() } else { 0 };
            let num2 = if i < v2.len() { v2[i].parse::<i32>().unwrap() } else { 0 };

            if num1 > num2 {
                return 1;
            } else if num1 < num2 {
                return -1;
            }
        }

        0
    }
}