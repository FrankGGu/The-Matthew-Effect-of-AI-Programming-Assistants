#define MAX_BOOKINGS 1000

typedef struct {
    int start;
    int end;
    int count;
} Booking;

typedef struct {
    Booking bookings[MAX_BOOKINGS];
    int bookingCount;
} Concert;

Concert* createConcert() {
    Concert* concert = (Concert*)malloc(sizeof(Concert));
    concert->bookingCount = 0;
    return concert;
}

bool bookConcert(Concert* concert, int start, int end, int count) {
    if (count <= 0 || start < 0 || end <= start) return false;

    for (int i = 0; i < concert->bookingCount; i++) {
        Booking b = concert->bookings[i];
        if (!(end <= b.start || start >= b.end)) {
            return false;
        }
    }

    concert->bookings[concert->bookingCount++] = (Booking){start, end, count};
    return true;
}

void freeConcert(Concert* concert) {
    free(concert);
}