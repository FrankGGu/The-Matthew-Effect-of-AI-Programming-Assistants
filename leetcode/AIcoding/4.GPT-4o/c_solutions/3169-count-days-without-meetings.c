int countDaysWithoutMeetings(int startDay, int endDay, int meetingDay) {
    int count = 0;
    for (int day = startDay; day <= endDay; day++) {
        if (day != meetingDay) {
            count++;
        }
    }
    return count;
}