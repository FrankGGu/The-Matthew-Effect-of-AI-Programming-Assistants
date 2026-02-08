impl Solution {
    pub fn compare_version(version1: String, version2: String) -> i32 {
        let v1: Vec<i32> = version1.split('.').map(|s| s.parse().unwrap()).collect();
        let v2: Vec<i32> = version2.split('.').map(|s| s.parse().unwrap()).collect();
        let len = v1.len().max(v2.len());

        for i in 0..len {
            let num1 = if i < v1.len() { v1[i] } else { 0 };
            let num2 = if i < v2.len() { v2[i] } else { 0 };
            if num1 < num2 {
                return -1;
            } else if num1 > num2 {
                return 1;
            }
        }
        0
    }
}