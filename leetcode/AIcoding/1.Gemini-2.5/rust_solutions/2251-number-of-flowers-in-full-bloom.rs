impl Solution {
    pub fn full_bloom_flowers(flowers: Vec<Vec<i32>>, people: Vec<i32>) -> Vec<i32> {
        let mut starts: Vec<i32> = Vec::with_capacity(flowers.len());
        let mut ends: Vec<i32> = Vec::with_capacity(flowers.len());

        for flower in flowers {
            starts.push(flower[0]);
            ends.push(flower[1] + 1); 
        }

        starts.sort_unstable();
        ends.sort_unstable();

        let mut result: Vec<i32> = Vec::with_capacity(people.len());

        for &person_time in people.iter() {
            let started_count = starts.partition_point(|&s| s <= person_time);
            let ended_count = ends.partition_point(|&e| e <= person_time);

            result.push((started_count - ended_count) as i32);
        }

        result
    }
}