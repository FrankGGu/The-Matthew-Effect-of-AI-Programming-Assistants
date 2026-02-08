impl Solution {
    pub fn garbage_collection(garbage: Vec<String>, travel: Vec<i32>) -> i32 {
        let mut last_g = 0;
        let mut last_p = 0;
        let mut last_m = 0;
        let mut count_g = 0;
        let mut count_p = 0;
        let mut count_m = 0;
        let mut travel_g = 0;
        let mut travel_p = 0;
        let mut travel_m = 0;

        for i in 0..garbage.len() {
            let s = &garbage[i];
            for c in s.chars() {
                if c == 'G' {
                    count_g += 1;
                    last_g = i;
                } else if c == 'P' {
                    count_p += 1;
                    last_p = i;
                } else {
                    count_m += 1;
                    last_m = i;
                }
            }
        }

        for i in 0..travel.len() {
            if i < last_g {
                travel_g += travel[i];
            }
            if i < last_p {
                travel_p += travel[i];
            }
            if i < last_m {
                travel_m += travel[i];
            }
        }

        count_g + count_p + count_m + travel_g + travel_p + travel_m
    }
}