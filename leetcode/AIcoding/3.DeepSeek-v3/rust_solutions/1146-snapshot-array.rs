use std::collections::BTreeMap;

struct SnapshotArray {
    snap_id: i32,
    array: Vec<BTreeMap<i32, i32>>,
}

impl SnapshotArray {
    fn new(length: i32) -> Self {
        let mut array = Vec::with_capacity(length as usize);
        for _ in 0..length {
            let mut map = BTreeMap::new();
            map.insert(0, 0);
            array.push(map);
        }
        SnapshotArray {
            snap_id: 0,
            array,
        }
    }

    fn set(&mut self, index: i32, val: i32) {
        self.array[index as usize].insert(self.snap_id, val);
    }

    fn snap(&mut self) -> i32 {
        self.snap_id += 1;
        self.snap_id - 1
    }

    fn get(&self, index: i32, snap_id: i32) -> i32 {
        *self.array[index as usize].range(..=snap_id).next_back().unwrap().1
    }
}