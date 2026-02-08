use std::collections::{VecDeque, BTreeMap};

struct MKAverage {
    m: usize,
    k: usize,
    data: VecDeque<i32>,
    small_set: BTreeMap<i32, usize>,
    mid_set: BTreeMap<i32, usize>,
    large_set: BTreeMap<i32, usize>,
    small_count: usize,
    mid_count: usize,
    large_count: usize,
    small_sum: i64,
    mid_sum: i64,
    large_sum: i64,
}

impl MKAverage {
    fn new(m: i32, k: i32) -> Self {
        MKAverage {
            m: m as usize,
            k: k as usize,
            data: VecDeque::with_capacity(m as usize),
            small_set: BTreeMap::new(),
            mid_set: BTreeMap::new(),
            large_set: BTreeMap::new(),
            small_count: 0,
            mid_count: 0,
            large_count: 0,
            small_sum: 0,
            mid_sum: 0,
            large_sum: 0,
        }
    }

    fn add_to_map(&mut self, map: &mut BTreeMap<i32, usize>, count: &mut usize, sum: &mut i64, val: i32) {
        *map.entry(val).or_insert(0) += 1;
        *count += 1;
        *sum += val as i64;
    }

    fn remove_from_map(&mut self, map: &mut BTreeMap<i32, usize>, count: &mut usize, sum: &mut i64, val: i32) {
        let entry = map.get_mut(&val).unwrap();
        *entry -= 1;
        if *entry == 0 {
            map.remove(&val);
        }
        *count -= 1;
        *sum -= val as i64;
    }

    fn pop_min_from_map(&mut self, map: &mut BTreeMap<i32, usize>, count: &mut usize, sum: &mut i64) -> i32 {
        let (&val, _) = map.iter().next().unwrap();
        self.remove_from_map(map, count, sum, val);
        val
    }

    fn pop_max_from_map(&mut self, map: &mut BTreeMap<i32, usize>, count: &mut usize, sum: &mut i64) -> i32 {
        let (&val, _) = map.iter().next_back().unwrap();
        self.remove_from_map(map, count, sum, val);
        val
    }

    fn remove_from_any_set(&mut self, val: i32) {
        if let Some(count) = self.small_set.get(&val) {
            if *count > 0 { self.remove_from_map(&mut self.small_set, &mut self.small_count, &mut self.small_sum, val); return; }
        }
        if let Some(count) = self.mid_set.get(&val) {
            if *count > 0 { self.remove_from_map(&mut self.mid_set, &mut self.mid_count, &mut self.mid_sum, val); return; }
        }
        if let Some(count) = self.large_set.get(&val) {
            if *count > 0 { self.remove_from_map(&mut self.large_set, &mut self.large_count, &mut self.large_sum, val); return; }
        }
        panic!("Value to remove not found in any set!");
    }

    fn rebalance_partitions(&mut self) {
        // Phase 1: Ensure `small_count` and `large_count` are at most `k`.
        if self.small_count > self.k {
            let val = self.pop_max_from_map(&mut self.small_set, &mut self.small_count, &mut self.small_sum);
            self.add_to_map(&mut self.mid_set, &mut self.mid_count, &mut self.mid_sum, val);
        }
        if self.large_count > self.k {
            let val = self.pop_min_from_map(&mut self.large_set, &mut self.large_count, &mut self.large_sum);
            self.add_to_map(&mut self.mid_set, &mut self.mid_count, &mut self.mid_sum, val);
        }

        // Phase 2: Ensure `small_count` and `large_count` are exactly `k` (if possible).
        if self.small_count < self.k && self.mid_count > 0 {
            let val = self.pop_min_from_map(&mut self.mid_set, &mut self.mid_count, &mut self.mid_sum);
            self.add_to_map(&mut self.small_set, &mut self.small_count, &mut self.small_sum, val);
        }
        if self.large_count < self.k && self.mid_count > 0 {
            let val = self.pop_max_from_map(&mut self.mid_set, &mut self.mid_count, &mut self.mid_sum);
            self.add_to_map(&mut self.large_set, &mut self.large_count, &mut self.large_sum, val);
        }

        // Phase 3: Ensure order property.
        if self.small_count > 0 && self.mid_count > 0 && *self.small_set.iter().next_back().unwrap().0 > *self.mid_set.iter().next().unwrap().0 {
            let s_max = self.pop_max_from_map(&mut self.small_set, &mut self.small_count, &mut self.small_sum);
            let m_min = self.pop_min_from_map(&mut self.mid_set, &mut self.mid_count, &mut self.mid_sum);
            self.add_to_map(&mut self.small_set, &mut self.small_count, &mut self.small_sum, m_min);
            self.add_to_map(&mut self.mid_set, &mut self.mid_count, &mut self.mid_sum, s_max);
        }
        if self.mid_count > 0 && self.large_count > 0 && *self.mid_set.iter().next_back().unwrap().0 > *self.large_set.iter().next().unwrap().0 {
            let m_max = self.pop_max_from_map(&mut self.mid_set, &mut self.mid_count, &mut self.mid_sum);
            let l_min = self.pop_min_from_map(&mut self.large_set, &mut self.large_count, &mut self.large_sum);
            self.add_to_map(&mut self.mid_set, &mut self.mid_count, &mut self.mid_sum, l_min);
            self.add_to_map(&mut self.large_set, &mut self.large_count, &mut self.large_sum, m_max);
        }
    }

    fn add_element(&mut self, val: i32) {
        self.data.push_back(val);

        if self.small_count == 0 || val <= *self.small_set.iter().next_back().unwrap().0 {
            self.add_to_map(&mut self.small_set, &mut self.small_count, &mut self.small_sum, val);
        } else if self.large_count == 0 || val >= *self.large_set.iter().next().unwrap().0 {
            self.add_to_map(&mut self.large_set, &mut self.large_count, &mut self.large_sum, val);
        } else {
            self.add_to_map(&mut self.mid_set, &mut self.mid_count, &mut self.mid_sum, val);
        }

        if self.data.len() > self.m {
            let old_val = self.data.pop_front().unwrap();
            self.remove_from_any_set(old_val);
        }
        self.rebalance_partitions();
    }

    fn calculate_mk_average(&mut self) -> i32 {
        if self.data.len() < self.m {
            return -1;
        }

        (self.mid_sum / self.mid_count as i64) as i32
    }
}