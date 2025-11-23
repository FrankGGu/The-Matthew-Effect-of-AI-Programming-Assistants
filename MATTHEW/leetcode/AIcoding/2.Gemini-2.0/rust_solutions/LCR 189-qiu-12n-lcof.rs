struct Calculator {
    current_value: i32,
}

impl Calculator {
    fn new(initial_value: i32) -> Self {
        Calculator {
            current_value: initial_value,
        }
    }

    fn add(&mut self, num: i32) -> i32 {
        self.current_value += num;
        self.current_value
    }

    fn subtract(&mut self, num: i32) -> i32 {
        self.current_value -= num;
        self.current_value
    }

    fn multiply(&mut self, num: i32) -> i32 {
        self.current_value *= num;
        self.current_value
    }

    fn divide(&mut self, num: i32) -> i32 {
        if num == 0 {
            panic!("Division by zero!");
        }
        self.current_value /= num;
        self.current_value
    }

    fn get_value(&self) -> i32 {
        self.current_value
    }
}