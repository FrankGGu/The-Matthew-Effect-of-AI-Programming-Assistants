pub fn count_vowel_substrings(s: String) -> i32 {
    let vowels = "aeiou";
    let mut count = 0;

    for i in 0..s.len() {
        let mut seen = [false; 5];
        let mut unique_count = 0;

        for j in i..s.len() {
            let c = s.chars().nth(j).unwrap();
            if vowels.contains(c) {
                let index = vowels.find(c).unwrap();
                if !seen[index] {
                    seen[index] = true;
                    unique_count += 1;
                }
                if unique_count == 5 {
                    count += 1;
                }
            } else {
                break;
            }
        }
    }

    count
}