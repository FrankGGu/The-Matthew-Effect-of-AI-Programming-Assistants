use std::collections::BinaryHeap;

impl Solution {
    pub fn schedule_course(mut courses: Vec<Vec<i32>>) -> i32 {
        courses.sort_by_key(|c| c[1]);

        let mut time: i32 = 0;
        let mut heap: BinaryHeap<i32> = BinaryHeap::new();

        for course in courses {
            let duration = course[0];
            let last_day = course[1];

            time += duration;
            heap.push(duration);

            if time > last_day {
                if let Some(max_duration) = heap.pop() {
                    time -= max_duration;
                }
            }
        }

        heap.len() as i32
    }
}