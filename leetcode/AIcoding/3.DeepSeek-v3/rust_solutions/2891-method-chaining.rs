#[derive(Debug)]
struct Animal {
    name: String,
    species: String,
    age: u32,
}

impl Animal {
    fn new(name: String, species: String, age: u32) -> Self {
        Animal { name, species, age }
    }

    fn name(&mut self, name: String) -> &mut Self {
        self.name = name;
        self
    }

    fn species(&mut self, species: String) -> &mut Self {
        self.species = species;
        self
    }

    fn age(&mut self, age: u32) -> &mut Self {
        self.age = age;
        self
    }

    fn build(&self) -> Self {
        Animal {
            name: self.name.clone(),
            species: self.species.clone(),
            age: self.age,
        }
    }
}