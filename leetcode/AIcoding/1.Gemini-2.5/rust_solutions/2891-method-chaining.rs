struct Calculator {
    value: i32,
}

impl Calculator {
    fn new(initial_value: i32) -> Self {
        Calculator { value: initial_value }
    }

    fn add(mut self, num: i32) -> Self {
        self.value += num;
        self
    }

    fn subtract(mut self, num: i32) -> Self {
        self.value -= num;
        self
    }

    fn multiply(mut self, num: i32) -> Self {
        self.value *= num;
        self
    }

    fn divide(mut self, num: i32) -> Self {
        if num != 0 {
            self.value /= num;
        }
        self
    }

    fn get_result(self) -> i32 {
        self.value
    }
}

struct Solution;

impl Solution {
    fn create_calculator(initial_value: i32) -> Calculator {
        Calculator::new(initial_value)
    }
}