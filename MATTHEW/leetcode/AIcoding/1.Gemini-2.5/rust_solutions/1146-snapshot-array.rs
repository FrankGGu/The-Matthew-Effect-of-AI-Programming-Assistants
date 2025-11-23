struct SnapshotArray {
    data: Vec<Vec<(i32, i32)>>,
    current_snap_id: i32,
}

impl SnapshotArray {
    fn new(length: i32) -> Self {
        let mut data = Vec::with_capacity(length as usize);
        for _ in 0..length {
            data.push(vec![(0, 0)]);
        }
        SnapshotArray {
            data,
            current_snap_id: 0,
        }
    }

    fn set(&mut self, index: i32, val: i32) {
        let history = &mut self.data[index as usize];
        if history.last().unwrap().0 == self.current_snap_id {
            history.last_mut().unwrap().1 = val;
        } else {
            history.push((self.current_snap_id, val));
        }
    }

    fn snap(&mut self) -> i32 {
        let old_snap_id = self.current_snap_id;
        self.current_snap_id += 1;
        old_snap_id
    }

    fn get(&self, index: i32, snap_id: i32) -> i32 {
        let history = &self.data[index as usize];
        let idx = history.partition_point(|&(s_id, _)| s_id <= snap_id);
        history[idx - 1].1
    }
}