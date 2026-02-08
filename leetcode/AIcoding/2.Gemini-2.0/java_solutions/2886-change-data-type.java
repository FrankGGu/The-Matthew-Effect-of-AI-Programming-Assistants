class Solution {

    public DataFrame changeDatatype(DataFrame students) {
        students.loc[:, "grades"] = students["grades"].astype(Object.class);
        return students;
    }
}