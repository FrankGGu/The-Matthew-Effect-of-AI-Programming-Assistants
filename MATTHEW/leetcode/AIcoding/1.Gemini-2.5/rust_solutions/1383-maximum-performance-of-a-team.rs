use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn max_performance(n: i32, speeds: Vec<i32>, efficiencies: Vec<i32>, k: i32) -> i64 {
        let mut engineers: Vec<(i32, i32)> = speeds
            .into_iter()
            .zip(efficiencies.into_iter())
            .collect();

        // Sort engineers by efficiency in descending order.
        // This ensures that when we iterate, the current engineer's efficiency
        // is always the minimum for any team formed with previously considered engineers.
        engineers.sort_unstable_by(|a, b| b.1.cmp(&a.1));

        let mut max_performance: i64 = 0;
        let mut current_speed_sum: i64 = 0;
        // A min-priority queue to keep track of the 'k' largest speeds among the
        // engineers considered so far (whose efficiency is >= current_engineer.efficiency).
        // We use `Reverse` to make `BinaryHeap` behave as a min-heap.
        let mut min_heap = BinaryHeap::new();

        for (speed, efficiency) in engineers {
            let speed_i64 = speed as i64;
            let efficiency_i64 = efficiency as i64;

            // Add the current engineer's speed to the running sum.
            current_speed_sum += speed_i64;
            // Add the current engineer's speed to the min-heap.
            min_heap.push(Reverse(speed));

            // If the number of engineers in our potential team (represented by the heap)
            // exceeds 'k', we must remove the engineer with the smallest speed
            // to maintain a team of 'k' engineers with the highest speeds.
            if min_heap.len() > k as usize {
                if let Some(Reverse(smallest_speed)) = min_heap.pop() {
                    current_speed_sum -= smallest_speed as i64;
                }
            }

            // Calculate the performance of the current team.
            // The minimum efficiency for this team is the efficiency of the current engineer
            // (due to the initial sorting).
            let current_performance = current_speed_sum * efficiency_i64;
            // Update the maximum performance found so far.
            max_performance = max_performance.max(current_performance);
        }

        max_performance
    }
}