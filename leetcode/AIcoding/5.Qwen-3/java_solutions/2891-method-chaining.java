public class Person {
    private String name;
    private int age;
    private String gender;

    public Person() {}

    public Person setName(String name) {
        this.name = name;
        return this;
    }

    public Person setAge(int age) {
        this.age = age;
        return this;
    }

    public Person setGender(String gender) {
        this.gender = gender;
        return this;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public String getGender() {
        return gender;
    }
}