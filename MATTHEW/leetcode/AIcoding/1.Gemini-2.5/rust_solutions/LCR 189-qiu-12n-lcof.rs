struct Accumulator {
    result: i32,
}

impl Accumulator {
    fn new() -> Self {
        Accumulator {
            result: 0,
        }
    }

    fn add(&mut self, value: i32) {
        self.result += value;
    }

    fn subtract(&mut self, value: i32) {
        self.result -= value;
    }

    fn multiply(&mut self, value: i32) {
        self.result *= value;
    }

    fn divide(&mut self, value: i32) {
        self.result /= value;
    }

    fn get_result(&self) -> i32 {
        self.result
    }
}