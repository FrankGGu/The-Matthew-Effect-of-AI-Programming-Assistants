impl Solution {
    pub fn compare_version(version1: String, version2: String) -> i32 {
        let v1_parts: Vec<i32> = version1
            .split('.')
            .map(|s| s.parse::<i32>().unwrap())
            .collect();
        let v2_parts: Vec<i32> = version2
            .split('.')
            .map(|s| s.parse::<i32>().unwrap())
            .collect();

        let max_len = v1_parts.len().max(v2_parts.len());

        for i in 0..max_len {
            let num1 = *v1_parts.get(i).unwrap_or(&0);
            let num2 = *v2_parts.get(i).unwrap_or(&0);

            if num1 < num2 {
                return -1;
            } else if num1 > num2 {
                return 1;
            }
        }

        0
    }
}