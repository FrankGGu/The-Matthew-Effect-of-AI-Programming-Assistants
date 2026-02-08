impl Solution {
    pub fn smallest_chair(times: Vec<Vec<i32>>, target_friend: i32) -> i32 {
        let mut events = Vec::new();
        for (i, time) in times.iter().enumerate() {
            events.push((time[0], i, 1)); // arrival
            events.push((time[1], i, -1)); // departure
        }
        events.sort();

        let mut occupied = vec![false; times.len()];
        let mut available_chairs = (0..times.len()).collect::<std::collections::VecDeque<_>>();

        for (time, index, event) in events {
            if event == 1 {
                if index == target_friend as usize {
                    return *available_chairs.front().unwrap();
                }
                let chair = available_chairs.pop_front().unwrap();
                occupied[chair] = true;
            } else {
                let chair = occupied.iter().position(|&x| x).unwrap();
                occupied[chair] = false;
                available_chairs.push_back(chair);
            }
        }
        -1 // Should not reach here
    }
}