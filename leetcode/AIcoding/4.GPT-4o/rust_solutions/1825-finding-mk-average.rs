use std::collections::BTreeMap;

struct MKAverage {
    m: usize,
    k: usize,
    stream: Vec<i32>,
    total: i32,
    count: usize,
    left: BTreeMap<i32, usize>,
    right: BTreeMap<i32, usize>,
}

impl MKAverage {
    fn new(m: i32, k: i32) -> Self {
        MKAverage {
            m: m as usize,
            k: k as usize,
            stream: Vec::new(),
            total: 0,
            count: 0,
            left: BTreeMap::new(),
            right: BTreeMap::new(),
        }
    }

    fn add_element(&mut self, num: i32) {
        if self.count < self.m {
            self.stream.push(num);
            self.total += num;
            self.count += 1;
            if self.count == self.m {
                self.initialize_buckets();
            }
        } else {
            let old = self.stream[self.count % self.m];
            self.stream[self.count % self.m] = num;
            self.total += num - old;
            self.update_buckets(old, num);
        }
        self.count += 1;
    }

    fn initialize_buckets(&mut self) {
        let mut sorted = self.stream.clone();
        sorted.sort_unstable();
        for &num in &sorted[..self.k] {
            *self.left.entry(num).or_insert(0) += 1;
        }
        for &num in &sorted[sorted.len() - self.k..] {
            *self.right.entry(num).or_insert(0) += 1;
        }
    }

    fn update_buckets(&mut self, old: i32, new: i32) {
        if self.left.contains_key(&old) {
            *self.left.get_mut(&old).unwrap() -= 1;
            if *self.left.get(&old).unwrap() == 0 {
                self.left.remove(&old);
            }
        } else {
            *self.right.get_mut(&old).unwrap() -= 1;
            if *self.right.get(&old).unwrap() == 0 {
                self.right.remove(&old);
            }
        }

        if self.left.len() < self.k {
            self.left.insert(new, self.left.get(&new).unwrap_or(&0) + 1);
        } else {
            self.right.insert(new, self.right.get(&new).unwrap_or(&0) + 1);
        }
    }

    fn calculate(&self) -> i32 {
        let total_count = self.count;
        if total_count < self.m {
            return -1;
        }
        let total_size = self.m - 2 * self.k;
        if total_size <= 0 {
            return 0;
        }
        let mut sum = self.total;
        for &num in self.left.keys() {
            sum -= num;
        }
        for &num in self.right.keys() {
            sum -= num;
        }
        sum / total_size as i32
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_mk_average() {
        let mut mk = MKAverage::new(3, 1);
        mk.add_element(3);
        mk.add_element(1);
        mk.add_element(10);
        assert_eq!(mk.calculate(), 3);
        mk.add_element(5);
        assert_eq!(mk.calculate(), 5);
        mk.add_element(5);
        assert_eq!(mk.calculate(), 5);
    }
}