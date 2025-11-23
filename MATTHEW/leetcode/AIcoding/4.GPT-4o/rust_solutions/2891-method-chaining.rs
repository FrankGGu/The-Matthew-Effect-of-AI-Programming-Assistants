struct Person {
    name: String,
    age: i32,
}

impl Person {
    pub fn new(name: String, age: i32) -> Self {
        Person { name, age }
    }

    pub fn set_name(mut self, name: String) -> Self {
        self.name = name;
        self
    }

    pub fn set_age(mut self, age: i32) -> Self {
        self.age = age;
        self
    }
}

impl ToString for Person {
    fn to_string(&self) -> String {
        format!("{} {}", self.name, self.age)
    }
}