function antOnBoundary(time, position) {
    return time % (2 * position) < position ? time % (2 * position) : 2 * position - (time % (2 * position));
}