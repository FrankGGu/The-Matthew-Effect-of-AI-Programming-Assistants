struct SnapshotArray {
    arr: Vec<i32>,
    snaps: Vec<Vec<i32>>,
    snap_id: i32,
}

impl SnapshotArray {
    fn new(length: i32) -> Self {
        SnapshotArray {
            arr: vec![0; length as usize],
            snaps: vec![],
            snap_id: 0,
        }
    }

    fn set(&mut self, index: i32, val: i32) {
        self.arr[index as usize] = val;
    }

    fn snap(&mut self) -> i32 {
        self.snaps.push(self.arr.clone());
        self.snap_id += 1;
        self.snap_id - 1
    }

    fn get(&self, index: i32, snap_id: i32) -> i32 {
        if snap_id < self.snaps.len() as i32 {
            self.snaps[snap_id as usize][index as usize]
        } else {
            0
        }
    }
}