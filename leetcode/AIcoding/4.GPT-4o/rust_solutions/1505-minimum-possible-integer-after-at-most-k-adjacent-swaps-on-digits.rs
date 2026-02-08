pub fn minimum_integer(s: String, k: i32) -> String {
    let mut digits: Vec<char> = s.chars().collect();
    let n = digits.len();
    let k = k as usize;

    for i in 0..n {
        let mut min_index = i;
        for j in (i + 1).min(i + k + 1)..n {
            if digits[j] < digits[min_index] {
                min_index = j;
            }
        }
        if min_index != i {
            let temp = digits[min_index];
            for j in (i..min_index).rev() {
                digits[j + 1] = digits[j];
            }
            digits[i] = temp;
            k -= min_index - i;
            if k == 0 {
                break;
            }
        }
    }

    digits.iter().collect()
}