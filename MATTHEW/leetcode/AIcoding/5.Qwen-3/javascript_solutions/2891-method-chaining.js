function Person() {
    this.name = null;
    this.age = null;
}

Person.prototype.setName = function(name) {
    this.name = name;
    return this;
};

Person.prototype.setAge = function(age) {
    this.age = age;
    return this;
};

Person.prototype.toString = function() {
    return `Name: ${this.name}, Age: ${this.age}`;
};