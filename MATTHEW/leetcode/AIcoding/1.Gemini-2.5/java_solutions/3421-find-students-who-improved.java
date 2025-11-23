import java.util.ArrayList;
import java.util.List;

class Student {
    int id;
    int score1;
    int score2;

    public Student(int id, int score1, int score2) {
        this.id = id;
        this.score1 = score1;
        this.score2 = score2;
    }

    public int getId() {
        return id;
    }

    public int getScore1() {
        return score1;
    }

    public int getScore2() {
        return score2;
    }
}

class Solution {
    public List<Integer> findStudentsWhoImproved(List<Student> students) {
        List<Integer> improvedStudentIds = new ArrayList<>();

        if (students == null || students.isEmpty()) {
            return improvedStudentIds;
        }

        for (Student student : students) {
            if (student.getScore2() > student.getScore1()) {
                improvedStudentIds.add(student.getId());
            }
        }

        return improvedStudentIds;
    }
}