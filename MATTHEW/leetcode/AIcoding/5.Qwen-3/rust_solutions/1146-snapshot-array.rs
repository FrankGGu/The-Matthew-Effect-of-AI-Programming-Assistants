impl Solution {

use std::collections::HashMap;

struct SnapshotArray {
    data: HashMap<i32, HashMap<i32, i32>>,
    current: HashMap<i32, i32>,
    snapshot_id: i32,
}

impl SnapshotArray {
    fn new(length: i32) -> Self {
        let mut data = HashMap::new();
        let mut current = HashMap::new();
        for i in 0..length {
            current.insert(i, 0);
        }
        SnapshotArray {
            data,
            current,
            snapshot_id: 0,
        }
    }

    fn set(&mut self, index: i32, val: i32) {
        self.current.insert(index, val);
    }

    fn snap(&mut self) -> i32 {
        let snapshot = self.current.clone();
        self.data.insert(self.snapshot_id, snapshot);
        let id = self.snapshot_id;
        self.snapshot_id += 1;
        id
    }

    fn get(&self, index: i32, snap_id: i32) -> i32 {
        let mut result = 0;
        for i in (0..snap_id).rev() {
            if let Some(map) = self.data.get(&i) {
                if let Some(val) = map.get(&index) {
                    return *val;
                }
            }
        }
        *self.current.get(&index).unwrap_or(&0)
    }
}
}