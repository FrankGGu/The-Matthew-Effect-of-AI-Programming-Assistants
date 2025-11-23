import java.util.Deque;
import java.util.LinkedList;

class FrontMiddleBackQueue {

    private Deque<Integer> front;
    private Deque<Integer> back;

    public FrontMiddleBackQueue() {
        front = new LinkedList<>();
        back = new LinkedList<>();
    }

    public void pushFront(int val) {
        front.offerFirst(val);
        balance();
    }

    public void pushMiddle(int val) {
        if (front.size() == back.size()) {
            back.offerFirst(val);
        } else {
            back.offerFirst(front.pollLast());
            front.offerLast(val);
        }
    }

    public void pushBack(int val) {
        back.offerLast(val);
        balance();
    }

    public int popFront() {
        if (front.isEmpty() && back.isEmpty()) {
            return -1;
        }
        if (front.isEmpty()) {
            return back.pollFirst();
        }
        int val = front.pollFirst();
        balance();
        return val;
    }

    public int popMiddle() {
        if (front.isEmpty() && back.isEmpty()) {
            return -1;
        }
        if (front.size() == back.size()) {
            return front.pollLast();
        } else {
            return back.pollFirst();
        }
    }

    public int popBack() {
        if (front.isEmpty() && back.isEmpty()) {
            return -1;
        }
        int val = back.pollLast();
        balance();
        return val;
    }

    private void balance() {
        while (front.size() > back.size()) {
            back.offerFirst(front.pollLast());
        }
        while (back.size() > front.size() + 1) {
            front.offerLast(back.pollFirst());
        }
    }
}