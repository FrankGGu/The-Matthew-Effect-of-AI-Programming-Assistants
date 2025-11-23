impl Solution {
    pub fn number_of_ways(people: Vec<Vec<i32>>) -> i32 {
        let n = people.len();
        let mut people = people;
        people.sort_by(|a, b| {
            if a[0] == b[0] {
                a[1].cmp(&b[1])
            } else {
                a[0].cmp(&b[0])
            }
        });

        let mut count = 0;
        for i in 0..n {
            let mut valid = true;
            for j in 0..n {
                if i == j {
                    continue;
                }
                if people[j][0] >= people[i][0] && people[j][0] <= people[i][1] {
                    if people[j][1] > people[i][1] {
                        valid = false;
                        break;
                    }
                }
            }
            if valid {
                count += 1;
            }
        }
        count
    }
}