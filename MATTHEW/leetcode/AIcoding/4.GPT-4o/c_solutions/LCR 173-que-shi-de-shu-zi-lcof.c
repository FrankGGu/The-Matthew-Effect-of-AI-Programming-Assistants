char * identifyStudents(int* student_ids, int student_ids_size, int* student_names, int student_names_size) {
    char *result = (char *)malloc(student_ids_size * 50 * sizeof(char));
    int index = 0;

    for (int i = 0; i < student_ids_size; i++) {
        if (i > 0) {
            index += sprintf(result + index, ", ");
        }
        index += sprintf(result + index, "%d: %s", student_ids[i], student_names[i]);
    }

    return result;
}