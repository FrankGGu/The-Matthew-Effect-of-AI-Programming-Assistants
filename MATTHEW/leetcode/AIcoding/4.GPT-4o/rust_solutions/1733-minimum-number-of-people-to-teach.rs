impl Solution {
    pub fn minimum_teachings(n: i32, languages: Vec<Vec<i32>>, friendships: Vec<Vec<i32>>) -> i32 {
        let mut can_communicate = vec![false; friendships.len()];
        let mut known_languages = vec![0; n as usize + 1];

        for (i, lang) in languages.iter().enumerate() {
            for &l in lang {
                known_languages[l as usize] |= 1 << i;
            }
        }

        for (i, (a, b)) in friendships.iter().enumerate() {
            if known_languages[languages[(a - 1) as usize].iter().sum::<i32>() as usize] & 
               known_languages[languages[(b - 1) as usize].iter().sum::<i32>() as usize] != 0 {
                can_communicate[i] = true;
            }
        }

        let mut teach_count = 0;
        let mut teach_languages = vec![0; n as usize + 1];

        for (i, &can) in can_communicate.iter().enumerate() {
            if !can {
                let a = friendships[i][0];
                let b = friendships[i][1];
                for &lang in &languages[(a - 1) as usize] {
                    teach_languages[lang as usize] += 1;
                }
                for &lang in &languages[(b - 1) as usize] {
                    teach_languages[lang as usize] += 1;
                }
            }
        }

        for count in teach_languages {
            if count > 0 {
                teach_count += 1;
            }
        }

        teach_count
    }
}