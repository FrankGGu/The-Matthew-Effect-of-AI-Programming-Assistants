impl Solution {
    pub fn reconstruct_queue(mut people: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        people.sort_unstable_by(|a, b| {
            if a[0] != b[0] {
                b[0].cmp(&a[0])
            } else {
                a[1].cmp(&b[1])
            }
        });

        let mut reconstructed_queue: Vec<Vec<i32>> = Vec::with_capacity(people.len());

        for person in people {
            reconstructed_queue.insert(person[1] as usize, person);
        }

        reconstructed_queue
    }
}