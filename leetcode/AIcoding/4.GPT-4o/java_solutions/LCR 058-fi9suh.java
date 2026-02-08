class MyCalendar {
    private List<int[]> bookings;

    public MyCalendar() {
        bookings = new ArrayList<>();
    }

    public boolean book(int start, int end) {
        for (int[] b : bookings) {
            if (Math.max(b[0], start) < Math.min(b[1], end)) {
                return false;
            }
        }
        bookings.add(new int[]{start, end});
        return true;
    }
}