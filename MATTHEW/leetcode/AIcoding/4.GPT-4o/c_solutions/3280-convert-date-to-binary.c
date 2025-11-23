char* convertDateToBinary(char* date) {
    int month, day, year;
    sscanf(date, "%d/%d/%d", &month, &day, &year);

    char* binary = (char*)malloc(11 * sizeof(char));
    sprintf(binary, "%04d%05d%07d", month, day, year);

    return binary;
}