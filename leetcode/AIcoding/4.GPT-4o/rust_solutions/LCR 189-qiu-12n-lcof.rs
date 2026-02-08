struct Accumulator {
    value: i32,
}

impl Accumulator {
    fn new() -> Self {
        Accumulator { value: 0 }
    }

    fn add(&mut self, number: i32) {
        self.value += number;
    }

    fn get(&self) -> i32 {
        self.value
    }
}