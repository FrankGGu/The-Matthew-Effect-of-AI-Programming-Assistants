def count_happy_students(students):
    return sum(1 for student in students if student == 'happy')

students = ["happy", "sad", "happy", "sad"]
print(count_happy_students(students))  # This line can be removed when submitting the code