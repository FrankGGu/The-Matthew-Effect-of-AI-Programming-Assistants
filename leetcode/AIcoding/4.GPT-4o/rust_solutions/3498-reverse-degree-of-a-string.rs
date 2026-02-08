impl Solution {
    pub fn reverse_degree(s: String) -> String {
        let mut count = vec![0; 26];
        for c in s.chars() {
            count[(c as usize) - ('a' as usize)] += 1;
        }
        let mut result = s.chars().collect::<Vec<_>>();
        let mut index = 0;
        for i in 0..26 {
            while count[i] > 0 {
                result[index] = (i as u8 + b'a') as char;
                index += 1;
                count[i] -= 1;
            }
        }
        result.reverse();
        result.into_iter().collect()
    }
}