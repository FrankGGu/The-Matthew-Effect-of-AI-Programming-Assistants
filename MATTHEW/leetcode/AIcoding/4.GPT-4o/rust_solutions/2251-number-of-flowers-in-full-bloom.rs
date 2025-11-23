impl Solution {
    pub fn num_of_blooming_flowers(flowers: Vec<Vec<i32>>, person: Vec<i32>) -> Vec<i32> {
        let mut count = vec![0; person.len()];
        let mut bloom_count = vec![0; flowers.len()];

        for i in 0..flowers.len() {
            for j in 0..person.len() {
                if flowers[i][0] <= person[j] && flowers[i][1] >= person[j] {
                    bloom_count[i] += 1;
                }
            }
        }

        for j in 0..person.len() {
            count[j] = bloom_count.iter().filter(|&&x| x > 0).count() as i32;
        }

        count
    }
}